// to update date and time

function updateDateTime(): void {
    const now: Date = new Date();
    const day: string = now.toLocaleDateString('en-US', { weekday: 'long' });
    const date: string = now.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
    const time: string = now.toLocaleTimeString('en-US');
    const dateTimeElement: HTMLElement | null = document.getElementById('dateTime');
    if (dateTimeElement) {
        dateTimeElement.innerText = `${day}, ${date}, ${time}`;
    }
}

// Update the date and time every second
setInterval(updateDateTime, 1000);

// Initial call to display the date and time immediately when the page loads
updateDateTime();
